Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:40206
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753285AbaBJUzG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Feb 2014 15:55:06 -0500
Date: Mon, 10 Feb 2014 15:55:00 -0500
Message-Id: <201402102055.s1AKt0q7015336@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: "Theodore Ts'o" <tytso@mit.edu>
CC: util-linux@vger.kernel.org
In-reply-to: <20140210185741.GF4724@thunk.org> (tytso@mit.edu)
Subject: Re: Typo in mkfs man-page
References: <CAFeW3TRKCNKtXv-9mQC86JM6xQNySQn=csJQFa2RqBRBnbujug@mail.gmail.com>
 <20140210173545.GK8506@x2.net.home> <20140210185741.GF4724@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: "Theodore Ts'o" <tytso@mit.edu>

> But /sbin/mkfs.xxx is generally run by system administrators, and IMHO
> it's better to tell people to run the command "/sbin/mkfs.xxx" instead
> of "/sbin/mkfs -t xxx".

This makes sense to me.

More exactly, mkfs is generally run "manually".

And while having fsck "do what I mean" is largely safe, creating a
file system is not the time that you want the user to be unclear on
the exact implications of each option he has specified.

Dale
