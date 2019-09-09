# Invoke-MacNotification

## SYNOPSIS
Triggers a notification to appear in OSX with the specified message and optional title, subtitle and sound alert.

## SYNTAX

```
Invoke-MacNotification [-Message] <String[]> [-Title <String>] [-Subtitle <String>] [-Sound <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is a PowerShell wrapper for the applescript 'display notification' command to trigger a custom notification
to be displayed on OSX.

## EXAMPLES

### EXAMPLE 1
```
Invoke-MacNotification -Message 'Hello!'
```

### EXAMPLE 2
```
Invoke-MacNotification -Message 'Hello! -Title 'Hello Message'
```

### EXAMPLE 3
```
Invoke-MacNotification -Message 'Hello!' -Sound 'Ping'
```

### EXAMPLE 4
```
1,2,3 | Invoke-MacNotification -Title 'Numbers'
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
