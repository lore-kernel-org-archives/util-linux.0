Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:48242 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755855Ab2ANRab (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 14 Jan 2012 12:30:31 -0500
Received: by obcva7 with SMTP id va7so3307964obc.19
        for <util-linux@vger.kernel.org>; Sat, 14 Jan 2012 09:30:31 -0800 (PST)
Message-ID: <4F11BBB4.4030602@gmail.com>
Date: Sat, 14 Jan 2012 11:30:28 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: getting a modern `more`
References: <201201130128.49700.vapier@gentoo.org> <201201132008.20863.vapier@gentoo.org> <4F10F3D5.9080706@gmail.com> <201201140039.17340.vapier@gentoo.org>
In-Reply-To: <201201140039.17340.vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> On Friday 13 January 2012 22:17:41 Bruce Dubbs wrote:
>> That said, if you want to spend the effort to update and maintain a
>> program that duplicates functionality, than that's up to you.  I just
>> think you may want to be careful of NIH thinking.
> 
> the work was already been done, and technically speaking, one could say that 
> everything other than "more" is NIH thinking ;).  can you name a pager that is 
> older than "more" ?

No, of course not.  Please understand that I have no connection with the 
'less' project.   I don't know why it forked, but it too has been around 
  since at least 1995 and appears to pre-date Linux (and Util-Linux). 
The website goes back to 'Version 290' in 1995.

I've been working with computers since before Unix (and Linux) and know 
a little computing history.  Before 'Glass TTYs' there were paper 
terminals and I suspect 'more' was designed with those paper terminals 
in mind.  'Less' appears to have been designed with terminals such as 
the VT100 in mind.  Sometimes it's beneficial to redesign a program when 
something new comes along rather than patch an old design.

   -- Bruce
