Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:64034 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753627AbbLCUNe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Dec 2015 15:13:34 -0500
Subject: Re: mount-user.c
To: "U.Mutlu" <for-gmane@mutluit.com>, util-linux@vger.kernel.org
References: <n2ibqp$ui6$1@ger.gmane.org> <564CC253.2080301@gmail.com>
 <n2j6ii$h1r$1@ger.gmane.org>
From: Michael Conrad <mconrad@intellitree.com>
Message-ID: <5660A0AC.40501@intellitree.com>
Date: Thu, 3 Dec 2015 15:06:04 -0500
MIME-Version: 1.0
In-Reply-To: <n2j6ii$h1r$1@ger.gmane.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Your script is vulnerable to PATH changes.  Also be aware of 
LD_LIBRARY_PATH attacks.  If you write a custom c program it should 
probably call the mount syscall directly.

But, you seem to forget the *most* dangerous mount abilities, which are 
device nodes and set-uid binaries.  Consider forcing nodev, noexec, and 
nosuid.

Also the "--move" and "--remount" options aren't safe.

And these are just the problems I know about...

-Mike

On 11/18/2015 7:53 PM, U.Mutlu wrote:
> Mantas Mikulėnas wrote on 11/18/2015 07:24 PM:
>> On 2015-11-18 19:17, U.Mutlu wrote:
>>> Currently no responsible admin can grant permission to the mount pgm
>>> to his users, because of the dangers inherent with bind-mounting etc.
>>>
>>> I suggest there should be an additional mount program destined for
>>> unpriviledged users (to be used via sudo).
>>>
>>> It should be a stripped down version of the mount pgm, with only some
>>> basic options for mounting, but without the dangerous options like
>>> bind-mount.
>>>
>>> The new program should of course have a different name, for example
>>> "usermount".
>>>
>>> I think this is the most clean solution to this problem.
>>>
>>> Users are intessted in mounting their own filesystems into
>>> their own mountpoints, ie. they don't neccesserily need fstab or 
>>> mtab etc.:
>>>    $ mkdir mymnt1 mymnt2
>>>    $ sudo usermount myfs.img ./mymnt1
>>>    $ sudo usermount my.iso   ./mymnt2
>>
>> fwiw, udisks2 already lets you mount removable drives and loop devices
>> under (/run)/media:
>>
>>    $ udisksctl mount -b /dev/sdb4
>>
>>    $ udisksctl loop-setup -f ~/foo.img
>
> Thanks, I'll check it out.
>
> In the meantime I wrote the following q&d wrapper around mount.
> I think this should be safe:
>
> /*
>   mount-user.c
>
>   A wrapper to the mount pgm filtering dangerous options like 
> bind-mounting.
>   Accepts all valid mount options and passes them to mount, except these:
>     -B  --bind
>     -o bind
>
>   Compile:
>     $ gcc -Wall -O2 mount-user.c -o mount-user
>
>   Install:
>     # cp -p mount-user /usr/local/bin
>     # chown root:root /usr/local/bin/mount-user
>     # chmod 755 /usr/local/bin/mount-user
>     #
>     # and add it to /etc/sudoers, so that permitted users can use it 
> like so:
>        $ sudo mount-user myfs.img mymntpoint
>
>   Advanced usage:
>     Use unshare-user (another useful user util by this author) prior
>     to make the user mounts hidden from the rest of the system.
>
>   History:
>     2015-11-18-We: v0.1b U.Mutlu: Init
>
> */
>
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>
> #define NELEMS(arr)  (sizeof(arr) / sizeof(arr[0]))
> #define errExit(msg) do { perror(msg); exit(EXIT_FAILURE); } while (0)
>
> int main(int argc, char* argv[])
>   {
>     char* aszIllegalOpts[] = { "-B", "--bind", "bind" };
>     int i, j;
>
>     for (i = 1; i < argc; ++i)
>       for (j = 0; j < NELEMS(aszIllegalOpts); ++j)
>         if (strstr(argv[i], aszIllegalOpts[j]))
>           {
>             printf("mount-user: error: illegal mount option '%s' 
> given\n",
>               aszIllegalOpts[j]);
>             return 1;
>           }
>
>     argv[0] = "mount";
>     execvp(argv[0], &argv[0]);
>     errExit("mount-user");
>   }
>
>
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

