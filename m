Return-Path: util-linux-owner@vger.kernel.org
Received: from stirling.just4dns.com ([178.18.116.215]:49076 "EHLO
	stirling.just4dns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaA2WkM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Jan 2014 17:40:12 -0500
Message-ID: <52E98342.8070103@stella-maris.org.uk>
Date: Wed, 29 Jan 2014 22:40:02 +0000
From: Stuart T Rogers <stuart@stella-maris.org.uk>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>
CC: util-linux@vger.kernel.org
Subject: Re: Possible problem mounting Video DVD
References: <52E7EBBC.4070009@stella-maris.org.uk> <201401282126.s0SLQFZK011980@hobgoblin.ariadne.com> <52E836E0.70900@stella-maris.org.uk> <201401292054.s0TKsrph021368@hobgoblin.ariadne.com>
In-Reply-To: <201401292054.s0TKsrph021368@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 29/01/14 20:54, Dale R. Worley wrote:
>> From: Stuart T Rogers <stuart@stella-maris.org.uk>
>
>> Sorry I did not make myself completely clear, these disks mount with the
>> wrong permissions, my user in this case uid 1000 has no access to the
>> directory structure of the DVD, either a filemanager or cd in a console
>> gets permission denied. All other DVDs I create from other recorders
>> will mount with uid 1000 having read access to the directory structure.
>
> Can you provide the exact mount command that you are using, an "ls
> -al" showing what user/group/permissions the files *are* showing up
> as, etc.?  There's a tremendous amount of information that you're not
> telling us, and even if I had your DVD and your computer in hand, I
> couldn't begin to verify that I'm seeing the same problem you are
> having.
>
> "How to Report Bugs Effectively"
> http://www.chiark.greenend.org.uk/~sgtatham/bugs.html
>
> Dale
>
OK let me explain, I am not issuing any mount commands myself. I place 
the DVD in the drive and close it, wait until it appears in the device 
notifier and select action Open in File Manager, when it opens having 
been mounted by the system at run/media/stuart/DVD_RECORDER the response 
from Dolphin is that the permissions wont allow me to open the root 
directory of the drive for browsing. If I try to play the video using 
Dragon etc again this works OK the permissions it is mounted with do not 
stop that action.

This should work. It does work for every other type of DVD Video that I 
use so long as it is NOT created on the Panasonic DVD Recorder.

I have had a thread open in Fedora forums at 
http://forums.fedoraforum.org/showthread.php?t=296874 which you can 
review to see what has been tried.

I dont expect to have to do any mount commands manually - the system 
should handle it for me.

Stuart
-- 
Website: http://www.stella-maris.org.uk
or:      http://www.broadstairs.org
