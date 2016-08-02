Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58086 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964846AbcHBOVv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 10:21:51 -0400
Date: Tue, 2 Aug 2016 15:56:50 +0200
From: Karel Zak <kzak@redhat.com>
To: "Veeraiyan Chidambaram (RBEI/ECF32)"
	<Veeraiyan.Chidambaram@in.bosch.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] liblkid: fix probe_nilfs2 I/O error backup
Message-ID: <20160802135650.mrbtnh6knrirfneg@ws.net.home>
References: <fc61fac781e54ced943435e9902b2a42@SGPMBX1019.APAC.bosch.com>
 <20160715083920.6wuhdp6ubllywltp@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715083920.6wuhdp6ubllywltp@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 15, 2016 at 10:39:20AM +0200, Karel Zak wrote:
> Would be enough to ignore the backup block errors if the primary block
> is valid?
... 
> Please, try the patch below.

Applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
