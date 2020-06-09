# Parameter examples
# $siteurl = "https://tenant.sharepoint.com/sites/Sitename"
# $FolderSiteRelativeURL = "/Documents"

param (
    [string]$SiteURL = $(throw "-SiteURL is required. Eg. https://tenant.sharepoint.com/sites/Sitename."),
    [string]$FolderSiteRelativeURL = $(throw "-FolderSiteRelativeURL is required. Eg. /Documents.")
)
write-output "Proceed deleting folder $FolderSiteRelativeURL with all its content in site $SiteURL?"

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

#Connect to the Site
Connect-PnPOnline -Url $SiteURL -UseWebLogin

#Get the web & folder
$Web = Get-PnPWeb
$Folder = Get-PnPFolder -Url $FolderSiteRelativeURL

#Function to delete all Files and sub-folders from a Folder
Function Empty-PnPFolder([Microsoft.SharePoint.Client.Folder]$Folder)
{
    #Get the site relative path of the Folder
	# Write-Host "ServerRelativeURL: " $web.ServerRelativeUrl	
    $FolderSiteRelativeURL = $Folder.ServerRelativeUrl.Replace($web.ServerRelativeUrl, "")	
	# Write-Host "FolderSiteRelativeURL: " $FolderSiteRelativeURL

    #Delete all files in the Folder
    $Files = Get-PnPFolderItem -FolderSiteRelativeUrl $FolderSiteRelativeURL -ItemType File
    ForEach ($File in $Files)
    {
        #Delete File
        Remove-PnPFile -ServerRelativeUrl $File.ServerRelativeURL -Force -Recycle
        Write-Host -f Green ("Deleted File: '{0}' at '{1}'" -f $File.Name, $File.ServerRelativeURL)        
    }

    #Process all Sub-Folders
    $SubFolders = Get-PnPFolderItem -FolderSiteRelativeUrl $FolderSiteRelativeURL -ItemType Folder
    Foreach($SubFolder in $SubFolders)
    {
        #Exclude "Forms" and Hidden folders
        If(($SubFolder.Name -ne "Forms") -and (-Not($SubFolder.Name.StartsWith("_"))))
        {
            #Call the function recursively
            Empty-PnPFolder -Folder $SubFolder

            #Delete the folder
            Remove-PnPFolder -Name $SubFolder.Name -Folder $FolderSiteRelativeURL -Force -Recycle
            Write-Host -f Green ("Deleted Folder: '{0}' at '{1}'" -f $SubFolder.Name, $SubFolder.ServerRelativeURL)
        }
    }
}

#Call the function to empty folder
Empty-PnPFolder -Folder $Folder

Disconnect-PnPOnline