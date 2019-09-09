# Invoke-AlerterNotification

## SYNOPSIS
Triggers an alerter notification to appear in OSX with the specified message and optional title, subtitle and sound alert.

## SYNTAX

```
Invoke-AlerterNotification [-Message] <String[]> [-Title <String>] [-Subtitle <String>] [-Sound <String>]
 [-Timeout <Int32>] [-AppIcon <String>] [-ContentImage <String>] [-Open <String>] [-Raw] [-Silent] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is a PowerShell wrapper for the application 'alerter' command to trigger a custom notification
to be displayed on OSX and handle a response/action.

## EXAMPLES

### EXAMPLE 1
```
Invoke-AlerterNotification -Message "Click 'Show' to open Google." -Open 'https://www.google.com'
```

### EXAMPLE 2
```
Invoke-AlerterNotification -Message 'Hello! -Title 'Hello Message' -Subtitle ':)' -Timeout 30 -AppIcon 'http://url.to/an/icon.png'
```

### EXAMPLE 3
```
Invoke-AlerterNotification -Message 'Hello!' -Sound 'Ping'
```

### EXAMPLE 4
```
1,2,3 | Invoke-AlerterNotification -Title 'Numbers'
```

## PARAMETERS

### -Message
The message text you want to appear in the notification.
This parameter is mandatory.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Title
Optional: The title text you want to appear in the notification.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: PowerShell Notification
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subtitle
Optional: The subtitle text you want to appear in the notification.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sound
OptionaL: The alert sound you want to play when the notification appears.
Must be one of the sounds from the default alert
sounds paths: '/System/Library/Sounds/','/Library/Sounds','~/Library/Sounds'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timeout
Optional: Number of seconds to wait before dismissing the notification automatically.
Default: waits indefinitely.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppIcon
Optional: The path or URL to an image to display as the application icon for the notification.
Alias: Icon

```yaml
Type: String
Parameter Sets: (All)
Aliases: Icon

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentImage
Optional: The path or URL to an image to display attached to the notification.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Open
Optional: A file or URL path to open if the 'show' button of the notification is clicked.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
Switch: Return raw text output instead of PowerShell Object output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Silent
Switch: Use to not return any object output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
