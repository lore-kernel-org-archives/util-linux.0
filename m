Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaJAK1f (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 06:27:35 -0400
Date: Wed, 1 Oct 2014 12:27:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/23] cfdisk: add missing initializers to struct
 main_menuitems
Message-ID: <20141001102719.GM26272@x2.net.home>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
 <1411933916-30576-16-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411933916-30576-16-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 28, 2014 at 08:51:48PM +0100, Sami Kerola wrote:
> disk-utils/cfdisk.c:149:77: warning: missing field 'userdata' initializer [-Wmissing-field-initializers]

 NACK ... why we have 
    UL_WARN_ADD([-Wno-missing-field-initializers])

 in configure?
 
 The -Wmissing-field-initializers is nonsense from C standard point of view.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
