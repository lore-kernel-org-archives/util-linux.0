Return-Path: util-linux-owner@vger.kernel.org
Received: from mta01.eastlink.ca ([24.224.136.30]:38741 "EHLO
	mta01.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbbAPDQC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Jan 2015 22:16:02 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta01.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NI80032BHRU21C1@mta01.eastlink.ca> for
 util-linux@vger.kernel.org; Thu, 15 Jan 2015 23:16:00 -0400 (AST)
Date: Thu, 15 Jan 2015 23:15:59 -0400
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: fix grammar and punctuation of 2.26 release notes
Message-id: <20150116031559.GW29504@cordes.ca>
References: <1421348945-2329-1-git-send-email-bensberg@justemail.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <1421348945-2329-1-git-send-email-bensberg@justemail.net>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

 Looks good, glad someone is taking the time to do this.  I ended up
taking the time myself to look up a few usage things in cases where it
looked odd to my English-Canadian eyes, but I wasn't sure.  :P


On Thu, Jan 15, 2015 at 08:09:05PM +0100, Benno Schulenberg wrote:
> Also trim some trailing whitespace.
> 
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  Documentation/releases/v2.26-ReleaseNotes |   70 ++++++++++++++--------------
>  1 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/releases/v2.26-ReleaseNotes b/Documentation/releases/v2.26-ReleaseNotes
> index b7712f7..68b09dd 100644
> --- a/Documentation/releases/v2.26-ReleaseNotes
> +++ b/Documentation/releases/v2.26-ReleaseNotes
> @@ -1,29 +1,29 @@
>  Util-linux 2.26 Release Notes
>  =============================
>  
> - This version provides completely new sfdisk(8) command, the new version is
> - based on libfdisk. If your use-cases depend on sfdisk(8) then it is strongly
> + This version provides a completely new sfdisk(8) command; the new version is
> + based on libfdisk. If your use cases depend on sfdisk(8) then it is strongly

 Should put a comma after "sfdisk(8)".

 At least some style guides are firm on this point, according to a
very quick google for if comma then.
https://www.constant-content.com/blog/2007/12/if-then-statements-require-commas/


>   recommended to be careful and re-test your scripts. The new version supports
> - MBR and GPT disk labels (SGI and SUN are also supported but no well tested).
> - The new version does no more support some obscure MBR specific command line
> + MBR and GPT disk labels (SGI and SUN are also supported but not well tested).
> + The new version no longer supports some obscure MBR-specific command-line
>   options and legacy CHS addressing.

 s/and/or/ in the last line.  "no longer supports x or y" is the proper
usage here.

>  
>  
> - The library libblkid (and blkid(8) on command line) now uses the same UDF
> - fields like Windows and another operations systems to get human readable
> - UDF volume identifiers (LABEL= tag). This change maybe backwardly incompatible 
> + The library libblkid (and blkid(8) on the command line) now uses the same UDF
> + fields as Windows and other operating systems in order to get human-readable
> + UDF volume identifiers (LABEL= tag). This change may be backwardly incompatible
>   for some UDF volumes.
>  
>  
>   The command hwclock(8) uses the drift correction for all relevant operations
> - and it is unnecessary to specify --adjuts on hwclock command line now.
> + and it is unnecessary to specify --adjust on the hwclock command line now.
>  
> - The command hwclock(8) does not automatically (re)calculate drift factor on
> - --systohc to avoid several problem (ntpd with an '11 minute mode', etc.), but
> - new command line option --update-drift has to be explicitly used to force
> - hwclock(8) to update /etc/adjtime. 
> + The command hwclock(8) does not automatically (re)calculate the drift factor on
> + --systohc to avoid several problems (ntpd with '11 minute mode', for example),
> + but the new command-line option --update-drift has to be explicitly used to
> + force hwclock(8) to update /etc/adjtime.

 Can we just start the sentence "hwclock(8) ...", instead of "The
command hwclock(8)"?  I don't think there's any ambiguity that you
might actually be talking about the man page.


>  
> - For more details see hwclock(8) man page.
> + For more details see the hwclock(8) man page.
>  
>  
>  Release highlights
> @@ -34,55 +34,55 @@ zramctl(8):
>  
>  agetty(8):
>   - supports new options --reload to force already running agetty processes to
> -   reprint /etc/issue file. 
> +   reprint the /etc/issue file

 "reprint /etc/issue" would work, and be shorter.


>  
>  cfdisk(8), sfdisk(8) and fdisk(8):
> - - supports sfdisk compatible scripts, it's possible to save your partitioning 
> -   layout to text files and (re)use it in all fdisks.
> + - supports sfdisk compatible scripts; it's possible to save your partitioning
> +   layout to text files and (re)use it in all fdisks

 Kudos for good use of a semicolon.  I always like a good semicolon. :)

>  
>  fdisk(8), sfdisk(8):
> - - support new command line option "--output <list>" to specify output columns
> -   for --list or print commands.
> + - support new command-line option "--output <list>" to specify output columns
> +   for --list or print commands
>  
>  nsenter(1):
>   - has been updated to work with the latest kernel changes in user namespaces
> - - supports new command line option --preserve-credentials
> + - supports new command-line option --preserve-credentials
>  
>  unshare(1):
>   - has been updated to work with the latest kernel changes in user namespaces
> - - suuports new command line option "--setgroups=<deny|allow>"
> + - supports new command-line option "--setgroups=<deny|allow>"
>  
>  swapon(8):
> - - supports new command line option "-o <list>" with the same semantic like
> -   -o for mount(8); now it's possible to specify swap options on command line
> -   by the same string like in fstab 
> + - supports new command-line option "-o <list>" with the same semantic as

 semantics, not semantic.

http://dictionary.reference.com/browse/semantic defines "semantic" as 
"of or relating to semantics".

> +   -o for mount(8); it's now possible to specify swap options on the command
> +   line by the same string as in fstab

 I think "with the same string", rather than "by the same string".

>  
>  fdformat(8):
> - - supports new command line options --from/to to specify tracks and --repear
> -   for broken floppies.
> + - supports new command-line options --from and --to to specify tracks and
> +   --repair for broken floppies

 Wow, people still use floppies, and are writing new code for them?

>  getopt(1):
> - - has been updated to the latest version (originally maintained out of
> -   util-linux) and refactored.
> + - has been updated to the latest version (originally maintained outside of
> +   util-linux) and refactored
>  
>  ldattach(8):
> - - has been improved to support GSM0710 and intro modem commands 
> + - has been improved to support GSM0710 and intro modem commands
>  
>  logger(1):
> - - supports new command line option --id= to specify PID (or another ID)
> + - supports new command-line option --id= to specify PID (or another ID)
>   - allows to specify --rfc3164 or --rfc5424 syslog protocols
>  
>  libfdisk:
> - - the library is distributed as shared library with stable API and standard
> -   header file.
> + - the library is distributed as a shared library with a stable API and a
> +   standard header file
>  
>  libmount:
> - - provides new simple API to monitor mount table changes (including
> -   changes in userspace mount options).
> + - provides a new simple API to monitor mount-table changes (including
> +   changes in userspace mount options)
>  
>  
> -The debug infrastructure in libraries libmount, libsmartcolsm, libfdisk and
> -libblkid allows to specify debug options by human readable strings too. For
> +The debug infrastructure in the libraries libmount, libsmartcolsm, libfdisk and
> +libblkid allows to specify debug options by human-readable strings too. For
>  example "LIBMOUNT_DEBUG=all mount /mnt".

"libblkid allows specifying debug options with human-readable strings, too. For"

 would read a bit better.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
