Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35701 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756403AbbDVKNm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Apr 2015 06:13:42 -0400
Date: Wed, 22 Apr 2015 12:13:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk, latest fixes break ppc64
Message-ID: <20150422101333.GE27969@ws.net.home>
References: <201504211234.27649.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504211234.27649.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 21, 2015 at 12:34:26PM +0200, Ruediger Meier wrote:
> the latest sfdisk fixes 2928068a..a53e37f9 seem to break ppc64

The latest changes in sfdisk only shows stupid LE/BE bugs we have in GPT
code. The problem should be fixed now.

It seems I have to compile and tests on Big Endian (ppc and s390)
more often, because we have no enough users who test it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
