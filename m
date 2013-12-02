Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57631 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516Ab3LBL0K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Dec 2013 06:26:10 -0500
Date: Mon, 2 Dec 2013 12:26:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: setterm -dump doesn't dump attributes
Message-ID: <20131202112605.GD5572@x2.net.home>
References: <529369D7.7030402@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <529369D7.7030402@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 25, 2013 at 10:16:39AM -0500, Phillip Susi wrote:
> The man page says -dump includes the attributes, but it does not.  Is
> this an error in the man page or the program?

It seems like a man page bug, there is nothing in the code about
attributes. So I have fixed the man page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
