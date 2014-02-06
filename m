Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28523 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaBFOgM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 6 Feb 2014 09:36:12 -0500
Date: Thu, 6 Feb 2014 15:36:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: cfdisk trips on out of order logical partitions
Message-ID: <20140206143608.GB12324@x2.net.home>
References: <52851A42.7090401@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52851A42.7090401@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 14, 2013 at 01:45:22PM -0500, Phillip Susi wrote:
> cfdisk's partition parsing logic is flawed in that it assumes they are
> in order, so if you have out of order partitions it complains that
> they overlap.

 Note that I'm working on new cfdisk version and out-of-order
 partition will be definitely supported.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
