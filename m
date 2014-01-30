Return-Path: util-linux-owner@vger.kernel.org
Received: from stirling.just4dns.com ([178.18.116.215]:40727 "EHLO
	stirling.just4dns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbaA3Tis (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jan 2014 14:38:48 -0500
Message-ID: <52EAAA43.8030509@stella-maris.org.uk>
Date: Thu, 30 Jan 2014 19:38:43 +0000
From: Stuart T Rogers <stuart@stella-maris.org.uk>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
Subject: Re: Possible problem mounting Video DVD
References: <52E7EBBC.4070009@stella-maris.org.uk> <201401282126.s0SLQFZK011980@hobgoblin.ariadne.com> <52E836E0.70900@stella-maris.org.uk> <201401292054.s0TKsrph021368@hobgoblin.ariadne.com> <52E98342.8070103@stella-maris.org.uk> <201401301906.s0UJ60YL023456@hobgoblin.ariadne.com>
In-Reply-To: <201401301906.s0UJ60YL023456@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 30/01/14 19:06, Dale R. Worley wrote:
>> From: Stuart T Rogers <stuart@stella-maris.org.uk>
>
>> OK let me explain, I am not issuing any mount commands myself. I place
>> the DVD in the drive and close it, wait until it appears in the device
>> notifier and select action Open in File Manager, when it opens having
>> been mounted by the system at run/media/stuart/DVD_RECORDER the response
>> from Dolphin is that the permissions wont allow me to open the root
>> directory of the drive for browsing. If I try to play the video using
>> Dragon etc again this works OK the permissions it is mounted with do not
>> stop that action.
>
> In regard to *playing* the videos, it's possible that the players
> don't mount the DVD as a file system at all, so the fact that they
> work isn't particularly informative.
>
> http://forums.fedoraforum.org/showthread.php?t=296874
>
> It looks like Skull One in that thread has the best explanation.  I'm
> not familiar with the details of mounting DVDs, but he suggests that
> the directories /run/media/stuart/DVD_VIDEO_RECORDER and
> /run/media/stuart/LG_VDR *on your disk* may have different
> permissions, and those permissions leak into the permissions seen when
> a DVD is mounted there.  So what are the permissions on those
> directories (when no DVD is mounted)?
>
> In any case, it's unlikely to be a problem that this mailing list
> deals with.  We only handle the mount executable.  One possibility is
> that the DVD mount and processing code in the kernel is providing
> unreasonable permission values (after all, it synthesizes them), in
> which case the fix is a kernel change.  Another possibility is that
> adjusting the permissions of /run/media/stuart/DVD_VIDEO_RECORDER will
> make the problem go away, in which case it can reasonably be
> considered to be a configuration error.  It's also possible that
> whatever is automounting the DVD isn't being smart enough about the
> permissions it is setting up for the DVD file system.  That would be a
> problem for the a different mailing list.
>
> Dale
>

Dale

Thanks for that explanation. The only thing regarding the DVD_RECORDER 
directory is that it does not exist until the DVD is mounted so whoever 
creates it sets the permissions. The name DVD_RECORDER is the volume 
name of the DVD. I'm not sure how the DVD can itself have permissions 
attributed to it though.

I will attempt to discover the right place to progress this issue.

Stuart

-- 
Website: http://www.stella-maris.org.uk
or:      http://www.broadstairs.org
