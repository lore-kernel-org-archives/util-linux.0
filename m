Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:47533
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751911AbaIGU5c (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 16:57:32 -0400
Date: Sun, 7 Sep 2014 16:57:28 -0400
Message-Id: <201409072057.s87KvSMh016001@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Bruce Dubbs <bruce.dubbs@gmail.com>
CC: util-linux@vger.kernel.org
In-reply-to: <540CA199.8070307@gmail.com> (bruce.dubbs@gmail.com)
Subject: Re: mount error message
References: <540CA199.8070307@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Bruce Dubbs <bruce.dubbs@gmail.com>

> $ mount /run
> 
> returns an error message:
> 
>    mount: /run: No such file or directory

Does the directory /run exist on the system?

If it exists, then this message should not be appearing.

If it does exist, and also /run isn't in /etc/fstab, then mount has
the choice of which error to report.

Dale
