Return-Path: util-linux-owner@vger.kernel.org
Received: from sender153-mail.zoho.com ([74.201.84.153]:22234 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbcCBXjy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Mar 2016 18:39:54 -0500
Message-ID: <56D779C4.3050800@zoho.com>
Date: Thu, 03 Mar 2016 00:39:48 +0100
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Stanislav Brabec <sbrabec@suse.cz>
CC: util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
References: <56D7409A.6050407@suse.cz>
In-Reply-To: <56D7409A.6050407@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/03/16 20:35, Stanislav Brabec wrote:
> Another possible fixes would be:
>
> - Request redirection of all I/O channels. (I. e. documentation fix
>    plus possible command line option to make it simpler.)
>
> - Or create custom pty container (like script does).
>
> - Or create a kernel level fix restricting TIOCSTI and let utilities as
>    they are.
>
> First two will have side effects, third seems to be a right way to me.

+1

IMHO a process without CAP_SYS_ADMIN (or similar) shouldn't be able to 
fake input¹ into a terminal owned² by a different user.


¹ yes, that's the goal of TIOCSTI)
² Not a complete solution, since you could have:
$ su root su $USER -s ./test_tiocsti

but if you are the owner of the terminal, it could do all kind of nasty 
things all the way down anyway.



> Additionally, https://bugzilla.redhat.com/show_bug.cgi?id=173008 says,
> that even it does not handle all possible attacks, because attacker can
> still read and write to the terminal:
>
> ==== steal.sh ====
> #!/bin/sh
> (
> sleep 3
> exec 0>&1
> echo "Hallo">/dev/stdout
> cat>/tmp/nobody-savefile
> )&
> ==================
>
> ~/util-linux # ./runuser -u nobody ./steal.sh
> ~/util-linux # Hallo

Nice use of background process with what is otherwise expected.
The is that the user is tricked into thinking that the child process 
[tree] has finished while it hasn't.

However, it doesn't seem work here:
> ./steal.sh: line 5: /dev/stdout: Permission denied
> cat: -: Input/output error


