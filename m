Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:50503 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766AbbKSAxx convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Nov 2015 19:53:53 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZzDTy-0003dV-Cv
	for util-linux@vger.kernel.org; Thu, 19 Nov 2015 01:53:50 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2015 01:53:50 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2015 01:53:50 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: mount-user.c
Date: Thu, 19 Nov 2015 01:53:37 +0100
Message-ID: <n2j6ii$h1r$1@ger.gmane.org>
References: <n2ibqp$ui6$1@ger.gmane.org> <564CC253.2080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <564CC253.2080301@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mantas Mikulėnas wrote on 11/18/2015 07:24 PM:
> On 2015-11-18 19:17, U.Mutlu wrote:
>> Currently no responsible admin can grant permission to the mount pgm
>> to his users, because of the dangers inherent with bind-mounting etc.
>>
>> I suggest there should be an additional mount program destined for
>> unpriviledged users (to be used via sudo).
>>
>> It should be a stripped down version of the mount pgm, with only some
>> basic options for mounting, but without the dangerous options like
>> bind-mount.
>>
>> The new program should of course have a different name, for example
>> "usermount".
>>
>> I think this is the most clean solution to this problem.
>>
>> Users are intessted in mounting their own filesystems into
>> their own mountpoints, ie. they don't neccesserily need fstab or mtab etc.:
>>    $ mkdir mymnt1 mymnt2
>>    $ sudo usermount myfs.img ./mymnt1
>>    $ sudo usermount my.iso   ./mymnt2
>
> fwiw, udisks2 already lets you mount removable drives and loop devices
> under (/run)/media:
>
>    $ udisksctl mount -b /dev/sdb4
>
>    $ udisksctl loop-setup -f ~/foo.img

Thanks, I'll check it out.

In the meantime I wrote the following q&d wrapper around mount.
I think this should be safe:

/*
   mount-user.c

   A wrapper to the mount pgm filtering dangerous options like bind-mounting.
   Accepts all valid mount options and passes them to mount, except these:
     -B  --bind
     -o bind

   Compile:
     $ gcc -Wall -O2 mount-user.c -o mount-user

   Install:
     # cp -p mount-user /usr/local/bin
     # chown root:root /usr/local/bin/mount-user
     # chmod 755 /usr/local/bin/mount-user
     #
     # and add it to /etc/sudoers, so that permitted users can use it like so:
        $ sudo mount-user myfs.img mymntpoint

   Advanced usage:
     Use unshare-user (another useful user util by this author) prior
     to make the user mounts hidden from the rest of the system.

   History:
     2015-11-18-We: v0.1b U.Mutlu: Init

*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NELEMS(arr)  (sizeof(arr) / sizeof(arr[0]))
#define errExit(msg) do { perror(msg); exit(EXIT_FAILURE); } while (0)

int main(int argc, char* argv[])
   {
     char* aszIllegalOpts[] = { "-B", "--bind", "bind" };
     int i, j;

     for (i = 1; i < argc; ++i)
       for (j = 0; j < NELEMS(aszIllegalOpts); ++j)
         if (strstr(argv[i], aszIllegalOpts[j]))
           {
             printf("mount-user: error: illegal mount option '%s' given\n",
               aszIllegalOpts[j]);
             return 1;
           }

     argv[0] = "mount";
     execvp(argv[0], &argv[0]);
     errExit("mount-user");
   }




