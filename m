Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:49664 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab2JJQJv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Oct 2012 12:09:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TLyr1-00067k-CY
	for util-linux@vger.kernel.org; Wed, 10 Oct 2012 18:09:51 +0200
Received: from 95.64.105.131 ([95.64.105.131])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 10 Oct 2012 18:09:51 +0200
Received: from terminatorul by 95.64.105.131 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 10 Oct 2012 18:09:51 +0200
To: util-linux@vger.kernel.org
From: Timothy Madden <terminatorul@gmail.com>
Subject: Re: `mount` command and POSIX Utility Syntax Guidelines
Date: Wed, 10 Oct 2012 19:09:38 +0300
Message-ID: <50759DC2.2000901@gmail.com>
References: <k52bu0$1up$1@ger.gmane.org> <20121010083655.GD28457@x2.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <20121010083655.GD28457@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/10/2012 11:36 AM, Karel Zak wrote:
> On Wed, Oct 10, 2012 at 02:28:06AM +0300, Timothy Madden wrote:
>> I have the little annoying problem that I can not mount a DAV folder with
>> the davfs2 filesystem, because I usually keep POSIXLY_CORRECT environment
>> variable set. The var allows me to keep an "aliases" file (similar to
>> ~/.basrc) and change it when needed if I put the file name in the ENV
>> variable.
>
>   Well, from my point of view is it mistake that getopt() supports
>   something like $POSIXLY_CORRECT. It's application, not library, who
>   has to control input/command line parsing.
[...]
>> Is it please possible for mount command to be updated to change the order of
>> arguments on the command line, so that it follows the POSIX guidelines?
>
>   The mount helpers command line is out documented API. I don't see a
>   way how to change it without break the compatibility between mount(8)
>   and mount.<type> helpers.
>
>> At least when POSIXLY_CORRECT is set in the environment ?
>
>   Don't assume that everyone uses getopt() from glibc. You can
>   use "if (strcmp(argv[], ...))" to parse command line arguments.
>
>   I think it would be better to remove POSIXLY_CORRECT from
>   mount.<type> environment in mount(8) before we execute the helper.

Maybe the mount helpers should follow POSIX guidelines, too.

Of the helpers that I have installed on my two systems (Slackware and 
CentOS), namely cifs, davfs, nfs/nfs4, ntfs/ntfs-3g/lowntfs-3g, it is 
only nfs that does indeed complain about syntax if I try to pass the 
options first and the operands next on the command line. Both my systems 
have "mount.nfs (linux nfs-utils 1.2.3)".

Maybe they can change the expected order for command line arguments (in 
the linux nfs-utils project), together with changes in mount, or before 
changes in mount (to be safe).

If anyone knows other mount helpers I should check for command line 
syntax, please jump in and add to the list.

Even without using GNU getopts(), I believe POSIX guidelines should 
still be taken into account, no matter how the command line is parsed or 
what library (or application) is used.

About removing POSIXLY_CORRECT before the mount helper is invoked, I 
would not easily take that path. I believe POSIXLY_CORRECT is a /user/ 
setting, with specific side-effects, and a such system command should 
not implicitly change it, without prior consent from the user. That is, 
the user might wonder why his mount helper, that he is working so hard 
on, does not receive the environment the user prepared for it and expects.

Thank you,
Timothy Madden


