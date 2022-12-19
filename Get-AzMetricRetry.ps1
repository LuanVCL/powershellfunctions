function Get-AzMetricRetry {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ResourceId,
        [string]$MetricName
    )
    $RetryCount = 0
    $MaxRetryCount = 3
    $RetryInterval = 5
    while ($RetryCount -lt $MaxRetryCount) {
        try {
            $UsageQuery = Get-AzMetric @GetAzMetricSplat -ResourceId $VM.ResourceId -MetricName $MetricName
            break
        } catch {
            $RetryCount++
            Start-Sleep -Seconds $RetryInterval
        }
    }
    return $UsageQuery
}