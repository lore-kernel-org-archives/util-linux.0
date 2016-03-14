Return-Path: util-linux-owner@vger.kernel.org
Received: from ns.horizon.com ([71.41.210.147]:29121 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933122AbcCNG63 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 02:58:29 -0400
Date: 14 Mar 2016 02:58:26 -0400
Message-ID: <20160314065826.10024.qmail@ns.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: e2fsck: /dev/hda2 is mounted.
Cc: linux@horizon.com
In-Reply-To: <20160313101414.19038.qmail@ns.horizon.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I dug back through the commit log, and discovered that reverting
7a4f98854283a5b98e76902b12685ad1999b2802 
fixes the regression.

I assume reverting this isn't the preferred solution, but it
at least narrows down the issue.
