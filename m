Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44685 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbcCIKnm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Mar 2016 05:43:42 -0500
Date: Wed, 9 Mar 2016 11:43:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Matthias Brugger <mbrugger@suse.com>
Cc: util-linux@vger.kernel.org, ruediger.meier@ga-group.nl
Subject: Re: [PATCH] Revert "Revert "tests: start script/race test only when
 --force specified""
Message-ID: <20160309104340.axpsgrvhf2o3llkh@ws.net.home>
References: <1457455978-8530-1-git-send-email-mbrugger@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457455978-8530-1-git-send-email-mbrugger@suse.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 08, 2016 at 05:52:58PM +0100, Matthias Brugger wrote:
> +# Don't execute this test by default, --force required
> +TS_OPTIONAL="yes"

 I have marked the test by

    TS_KNOWN_FAIL="yes

 it seems better than disable the test.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
