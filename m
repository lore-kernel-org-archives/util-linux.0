Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327AbcDFM0Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 08:26:25 -0400
Date: Wed, 6 Apr 2016 14:26:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: test_md5 prints md5sum only
Message-ID: <20160406122615.foxdi772wqthsxfc@ws.net.home>
References: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 06, 2016 at 12:30:17PM +0200, Ruediger Meier wrote:
> We want to to use it for other tests without depending on
> gnu md5sum and without cut or awk.

It does not seem like anything critical, both patches applied to the
next branch (will be in v2.29). Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
