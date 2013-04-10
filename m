Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55916 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab3DJNBs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Apr 2013 09:01:48 -0400
Date: Wed, 10 Apr 2013 14:30:18 +0200
From: Karel Zak <kzak@redhat.com>
To: sergio <mailbox@sergio.spb.ru>
Cc: util-linux@vger.kernel.org
Subject: Re: lscpu should show model name
Message-ID: <20130410123018.GC26442@x2.net.home>
References: <51653A7F.8060807@sergio.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51653A7F.8060807@sergio.spb.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 10, 2013 at 02:10:07PM +0400, sergio wrote:
> Could you add model name field to the lscpu's output.
> Like cat /proc/cpuinfo | grep 'model name'

 Implemented.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
