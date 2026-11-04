# Publishes the staged module directly via Publish-Module rather than through the PSDeploy DSL --
# PSDeploy has previously failed to load reliably on the macOS build image this module requires,
# so this calls Publish-Module directly instead.
# Set-BuildEnvironment from BuildHelpers module has populated ENV:BHModulePath and related variables.
# $env:BHStagingModulePath is set by the psake 'Deploy' task when the combined module built by
# CombineFunctionsAndStage is available -- a bare psake Properties variable wouldn't be visible here, since
# this file is dot-sourced directly from inside the Deploy task's own scriptblock scope.
if ($env:BHStagingModulePath -and (Test-Path $env:BHStagingModulePath)) {
    $ModuleSourcePath = $env:BHStagingModulePath
}
else {
    $ModuleSourcePath = $env:BHPSModulePath
}

# The branch that's allowed to publish to the Gallery is a deploy gate, not something to infer (e.g. from
# the repo's default branch) -- it's set explicitly via the workflow's DeployBranch env var, defaulting to
# 'master' for local/manual runs where that env var isn't set.
$DeployBranch = if ($env:DeployBranch) { $env:DeployBranch } else { 'master' }

# Publish to gallery with a few restrictions
if (
    $ModuleSourcePath -and
    $env:BHBuildSystem -ne 'Unknown' -and
    $env:BHBranchName -eq $DeployBranch -and
    $env:NugetApiKey
) {
    Publish-Module -Path $ModuleSourcePath -NuGetApiKey $env:NugetApiKey
}
else {
    "Skipping deployment: To deploy, ensure that...`n" +
    "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
    "`t* You are committing to the $DeployBranch branch (Current: $ENV:BHBranchName) `n" +
    "`t* You have access to the Nuget API key" |
        Write-Host
}
