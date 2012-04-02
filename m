Return-Path: P@draigBrady.com
Message-ID: <4F7999F7.7030808@draigBrady.com>
Date: Mon, 02 Apr 2012 13:22:15 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] chkdupexe: reimplement command in C
References: <20120330150457.GE23437@x2.net.home> <1333304372-25944-1-git-send-email-kerolasa@iki.fi> <1333304372-25944-4-git-send-email-kerolasa@iki.fi> <20120402111029.GA1084@x2.net.home>
In-Reply-To: <20120402111029.GA1084@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 04/02/2012 12:10 PM, Karel Zak wrote:
> On Sun, Apr 01, 2012 at 08:19:32PM +0200, Sami Kerola wrote:
>> The new version of the command is nearly identical to old.  Major
>> differences are:
>>
>> * New output is a little rough what comes to alignment.  This is
>>   flagged as FIXME item in source.
>> * The command is much quicker than perl implementation which used
>>   to exec ls -ldU.
>> * Size of chkdupexe binary is about five times bigger than perl
>>   script.
> 
> I have doubts about chkdupexe, do we really need this command?
> 
>  * it provides very rarely used functionality (for example nobody
>    complains that the command is missing in Fedora/RHEL ;-)
> 
>  * it seems that you can replace it by
> 
>     ls $(echo "$PATH" | tr : ' ') | sort | uniq -d
> 
>    or we can extend which(1) or so...
> 
> 
>  I see two possible ways:
> 
>  1) mark chkdupexe as deprecated and remove it from distros

I notice it's no longer on my Fedora 15 distro at least.

>  2) or add new command (lspath ?) and get much more information from
>  $PATH (like duplicates, per-directory stats, per-owner stats,
>  per-device stats, selinux summary, suids, etc.) and make chkdupexe as
>  alias to the new command (just for backward compatibility).

Possible but unlikely

>  If 2) makes sense then it would be better to have it in coreutils ;-)

I'd vote for 1.
Note I actually wrote a very similar tool as part of fslint, called findsn.
It has different modes of operation, but the default is the same as chkdupexe.

$ ~/git/util-linux/misc-utils/chkdupexe.pl
Dangling symlink: /usr/bin/openoffice.org
-rwxr-xr-x. 1 root    root    86360 Feb  8  2011 /usr/bin/bc
-rwxrwxr-x. 1 padraig padraig  1767 Apr 11  2007 /home/padraig/bin/bc
-rwxr-xr-x. 1 root    root    50616 Aug 25  2011 /usr/bin/timeout
-rwxrwxr-x. 1 padraig padraig  2141 Oct 29  2009 /home/padraig/bin/timeout
-rwxr-xr-x. 1 root    root    51176 Feb  8  2011 /usr/bin/truncate
-rwxrwxr-x. 1 padraig padraig  1273 Dec 16  2005 /home/padraig/bin/truncate

$ fslint/findsn
-rwxr-xr-x. 1 root    root    86360 Feb  8  2011 /usr/bin/bc
-rwxrwxr-x. 1 padraig padraig  1767 Apr 11  2007 /home/padraig/bin/bc
lrwxrwxrwx. 1 root    root        2 May 13  2011 /bin/ex -> vi
lrwxrwxrwx. 1 root    root        3 May 22  2011 /usr/bin/ex -> vim
-rwxr-xr-x. 1 root    root    50616 Aug 25  2011 /usr/bin/timeout
-rwxrwxr-x. 1 padraig padraig  2141 Oct 29  2009 /home/padraig/bin/timeout
-rwxr-xr-x. 1 root    root    51176 Feb  8  2011 /usr/bin/truncate
-rwxrwxr-x. 1 padraig padraig  1273 Dec 16  2005 /home/padraig/bin/truncate

$ ./fslint/findbl $(fslint/supprt/getffp)
/usr/bin/openoffice.org -> /usr/lib64/libreoffice/program/libreoffice

cheers,
Pádraig.
