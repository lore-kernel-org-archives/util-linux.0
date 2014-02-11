Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35870 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaBKJFd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Feb 2014 04:05:33 -0500
Received: by mail-pa0-f53.google.com with SMTP id lj1so7386534pab.12
        for <util-linux@vger.kernel.org>; Tue, 11 Feb 2014 01:05:32 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201402102055.s1AKt0q7015336@hobgoblin.ariadne.com>
References: <CAFeW3TRKCNKtXv-9mQC86JM6xQNySQn=csJQFa2RqBRBnbujug@mail.gmail.com>
	<20140210173545.GK8506@x2.net.home>
	<20140210185741.GF4724@thunk.org>
	<201402102055.s1AKt0q7015336@hobgoblin.ariadne.com>
Date: Tue, 11 Feb 2014 09:05:32 +0000
Message-ID: <CAG27Bk09kBXQ3B1Vtm6oDxw2iyqvsYbj9uYyGTdBgfLnLAvtsg@mail.gmail.com>
Subject: Re: Typo in mkfs man-page
From: Sami Kerola <kerolasa@iki.fi>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: "Theodore Ts'o" <tytso@mit.edu>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10 February 2014 20:55, Dale R. Worley <worley@alum.mit.edu> wrote:
>> From: "Theodore Ts'o" <tytso@mit.edu>
>
>> But /sbin/mkfs.xxx is generally run by system administrators, and IMHO
>> it's better to tell people to run the command "/sbin/mkfs.xxx" instead
>> of "/sbin/mkfs -t xxx".
>
> This makes sense to me.
>
> More exactly, mkfs is generally run "manually".
>
> And while having fsck "do what I mean" is largely safe, creating a
> file system is not the time that you want the user to be unclear on
> the exact implications of each option he has specified.

Would it make sense to add banner 'you probably should not run this
utility, consider using file system specific mkfs' to mkfs?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
