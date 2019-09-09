Class SoundNames : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {

        $SoundNames = ForEach ($SoundPath in '/System/Library/Sounds/', '/Library/Sounds', '~/Library/Sounds') {
            if (Test-Path $SoundPath) {
                (Get-ChildItem $SoundPath).BaseName
            }
        }
        return [string[]] $SoundNames
    }
}