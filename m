Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:36660 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756759Ab3DYN0g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Apr 2013 09:26:36 -0400
Received: from public by plane.gmane.org with local (Exim 4.69)
	(envelope-from <public@plane.gmane.org>)
	id 1UVMC3-0007gQ-B3
	for util-linux@vger.kernel.org; Thu, 25 Apr 2013 15:26:35 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Karel Zak <public-kzak-H+wXaHxf7aLQT0dZR+AlfA@plane.gmane.org>
Cc: public-linux-kernel-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org,
        public-linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org,
        public-util-linux-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
Subject: Re: [ANNOUNCE] util-linux 2.23
References: <20130425110450.GF2244@x2.net.home>
Date: Thu, 25 Apr 2013 06:25:03 -0700
In-Reply-To: <20130425110450.GF2244@x2.net.home> (Karel Zak's message of "Thu,
	25 Apr 2013 13:04:50 +0200")
Message-ID: <m2haiuvj2o.fsf@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:
>
> Util-linux 2.23 Release Notes
> =============================
>
> The cryptoloop support in the commands mount(8) and losetup(8) has been
> REMOVED. The encryption= mount option and -e,-E,--encryption losetup options
> are no more supported.

That's crazy. You're taking away access to existing data.

-Andi

