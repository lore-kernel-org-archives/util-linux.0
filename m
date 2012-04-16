Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58693 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab2DPMXm (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 16 Apr 2012 08:23:42 -0400
Date: Mon, 16 Apr 2012 14:23:39 +0200
From: Karel Zak <kzak@redhat.com>
To: "Males, Jess L." <malesjl@ornl.gov>
Cc: "util-linux-ng@vger.kernel.org" <util-linux-ng@vger.kernel.org>
Subject: Re: mount bind options
Message-ID: <20120416122339.GB6935@x2.net.home>
References: <CBA36CB2.C75%malesjl@ornl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CBA36CB2.C75%malesjl@ornl.gov>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 05, 2012 at 03:37:22PM -0400, Males, Jess L. wrote:
> I'm trying:
> Mount -o bind,gid=10101 /path/to/some/dir /new/mnt/

The bind operation cannot be mixed with another flag/option. This is
not supported by Linux kernel.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
