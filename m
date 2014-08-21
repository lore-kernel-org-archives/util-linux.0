Return-Path: util-linux-owner@vger.kernel.org
Received: from b.b.painless.aa.net.uk ([81.187.30.62]:46799 "EHLO
	b.b.painless.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaHUQH6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Aug 2014 12:07:58 -0400
Received: from cartman.offog.org ([2001:8b0:83b:b53f::a])
	by b.painless.aa.net.uk with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <ats@offog.org>)
	id 1XKUKF-0005EZ-K3
	for util-linux@vger.kernel.org; Thu, 21 Aug 2014 16:30:59 +0100
Received: from ats by cartman.offog.org with local (Exim 4.83)
	(envelope-from <ats@offog.org>)
	id 1XKUKE-0008SJ-Np
	for util-linux@vger.kernel.org; Thu, 21 Aug 2014 16:30:54 +0100
From: Adam Sampson <ats@offog.org>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] mountpoint: drop S_ISDIR check
References: <1408625292-2445-1-git-send-email-dreisner@archlinux.org>
	<53F608BA.4080401@bernhard-voelker.de>
Date: Thu, 21 Aug 2014 16:30:54 +0100
In-Reply-To: <53F608BA.4080401@bernhard-voelker.de> (Bernhard Voelker's
	message of "Thu, 21 Aug 2014 16:56:58 +0200")
Message-ID: <y2aa96xc11t.fsf@cartman.at.offog.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bernhard Voelker <mail@bernhard-voelker.de> writes:

> just out of curiosity - how?

It's certainly possible with bind mounts:

  # touch /foo
  # mount --bind /etc/hostname /foo
  # mountpoint /foo
  mountpoint: /foo: not a directory

(whereas it works fine for a bind-mounted directory).

However, the mountpoint(1) man page talks explicitly about the argument
being a directory, so that should probably be updated as well if it now
works on files too.

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
