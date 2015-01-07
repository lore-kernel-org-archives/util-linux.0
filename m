Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbbAGO0o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Jan 2015 09:26:44 -0500
Date: Wed, 7 Jan 2015 15:26:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: libsmartcols patch
Message-ID: <20150107142638.GH15715@x2.net.home>
References: <54A0AE98.70503@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54A0AE98.70503@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 28, 2014 at 08:30:00PM -0500, Phillip Susi wrote:
> Forwarding patch from https://launchpad.net/bugs/1406133:
 
 Applied with some changes, note that the patch does not resolve
 situation when the tree is not the first column, for example:

    $ findmnt -o SOURCE,FSTYPE,OPTIONS,TARGET

 but it's fine. I have tried to implement it for for trees after the line break
 and then the output is pretty unreadable. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
