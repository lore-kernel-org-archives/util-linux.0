Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbaHDMCs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Aug 2014 08:02:48 -0400
Date: Mon, 4 Aug 2014 14:02:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] zramctl: print all devices as a default action
Message-ID: <20140804120238.GB6923@x2.net.home>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 03, 2014 at 03:17:37PM +0100, Sami Kerola wrote:
> This commit makes the command to display information about all zram
> devices when the command is ran without any arguments.  Listing includes

 I don't think it's a good idea do it by default. The current zramctl
 follows the logic we use for losetup (or lsblk), it means "list all
 used devices". I'm not sure if we really need to list empty devices,
 such devices are /dev nodes only. Maybe we can add --all if you have
 any use-case for this feature.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
