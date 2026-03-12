$start = Get-Date "2026-01-15"
$end = Get-Date "2026-03-12"

$targetCommits = 83
$targetActiveDays = 32   # commits only on some days to look natural

$messages = @(
"initialize eventhub project structure",
"setup express server and mongodb connection",
"add user model and authentication middleware",
"implement user registration api",
"implement login api with jwt",
"add refresh token utility",
"create event model and event controller",
"implement category api routes",
"add enquiry controller logic",
"implement assign event functionality",
"add payment model and razorpay integration",
"implement nodemailer email utilities",
"add otp generation and verification",
"setup multer middleware for uploads",
"add cloudinary upload utility",
"create frontend nextjs app structure",
"implement homepage hero section",
"add event listing page",
"implement event details page",
"add category events filtering",
"create dashboard layout",
"implement admin dashboard analytics",
"add organizer dashboard components",
"implement event creation form",
"add event editing functionality",
"implement user management table",
"add revenue analytics charts",
"integrate frontend with backend apis",
"add redux slices for state management",
"implement favorites feature",
"add profile page functionality",
"fix api response handling",
"improve ui loading states",
"add skeleton loaders",
"optimize api services",
"fix authentication bugs",
"improve dashboard responsiveness",
"refactor event controllers",
"cleanup unused components",
"add toast notifications",
"improve error handling",
"fix booking issues",
"final ui polish and bug fixes"
)

$dates = @()
$d = $start

while ($d -le $end) {
    $dates += $d
    $d = $d.AddDays(1)
}

$activeDays = $dates | Get-Random -Count $targetActiveDays
$activeDays = $activeDays | Sort-Object

$commitCount = 0

foreach ($day in $activeDays) {

    $commitsToday = Get-Random -Minimum 1 -Maximum 4

    for ($i=0; $i -lt $commitsToday; $i++) {

        if ($commitCount -ge $targetCommits) { break }

        $msg = Get-Random $messages

        Add-Content temp.txt "$msg $(Get-Random)"

        git add .

        $time = Get-Date $day -Hour (Get-Random -Minimum 9 -Maximum 23) -Minute (Get-Random -Minimum 0 -Maximum 59)

        $env:GIT_AUTHOR_DATE = $time.ToString("yyyy-MM-ddTHH:mm:ss")
        $env:GIT_COMMITTER_DATE = $env:GIT_AUTHOR_DATE

        git commit -m $msg

        $commitCount++
    }

    if ($commitCount -ge $targetCommits) { break }
}