#Connect to the Site
# Connect-PnPOnline -Url $siteurl -UseWebLogin

# Parameter examples:
# $siteurl = "https://schweitzerchemie.sharepoint.com/sites/DokumentationTechnikprojekte2"
# $FolderSiteRelativeURL = "/Dokumente"

param (
    [string]$SiteURL = $(throw "-SiteURL is required. Eg. https://tenant.sharepoint.com/sites/Sitename."),
    [string]$FolderSiteRelativeURL = $(throw "-FolderSiteRelativeURL is required. Eg. /Documents.")
)
write-output "Proceed undoing all checkouts from folder $FolderSiteRelativeURL in site $SiteURL?"

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

#Get the web & folder
$Web = Get-PnPWeb
$Folder = Get-PnPFolder -Url $FolderSiteRelativeURL


# Function to delete all files and sub-folders from a folder
Function UndoCheckOuts-PnPFolder([Microsoft.SharePoint.Client.Folder]$Folder)
{
    #Get the site relative path of the Folder
    $FolderSiteRelativeURL = $Folder.ServerRelativeUrl.Replace($web.ServerRelativeUrl,"")
	
	Write-Host $FolderSiteRelativeURL

    #Delete all files in the Folder
    $Files = Get-PnPFolderItem -FolderSiteRelativeUrl $FolderSiteRelativeURL -ItemType File
    ForEach ($File in $Files)
    {
		$File.UndoCheckOut()	
        Write-Host -f Green ("Undo CheckOut: '{0}' at '{1}'" -f $File.Name, $File.ServerRelativeURL)        
    }

    # Iterate recursively through the sub folders
    $SubFolders = Get-PnPFolderItem -FolderSiteRelativeUrl $FolderSiteRelativeURL -ItemType Folder
    Foreach($SubFolder in $SubFolders)
    {
        # Exclude "Forms" and Hidden folders
        If(($SubFolder.Name -ne "Forms") -and (-Not($SubFolder.Name.StartsWith("_"))))
        {
            UndoCheckOuts-PnPFolder -Folder $SubFolder
        }
    }
}

# Call the function
UndoCheckOuts-PnPFolder -Folder $Folder

Disconnect-PnPOnline