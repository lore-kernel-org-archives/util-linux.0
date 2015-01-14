Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55434 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbbANUgJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Jan 2015 15:36:09 -0500
Date: Wed, 14 Jan 2015 21:13:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Lucio Crusca <lucio@sulweb.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [BUG] losetup: support for physical devices
Message-ID: <20150114201302.GH28019@x2.net.home>
References: <m96ard$qu8$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m96ard$qu8$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 14, 2015 at 06:59:58PM +0100, Lucio Crusca wrote:
> http://serverfault.com/questions/659484

 BTW, it should be possible to use delpart(8) to release sdc1
 partition and use addpart(8) to define the partition from 
 another offset. Then you avoid /deb/loopN at all.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
