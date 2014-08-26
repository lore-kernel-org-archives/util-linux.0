Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40029 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934498AbaHZO6c (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Aug 2014 10:58:32 -0400
Date: Tue, 26 Aug 2014 16:58:28 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: cfdisk wipes out partition table when trying to replace a single
 logical partition
Message-ID: <20140826145828.GJ14708@x2.net.home>
References: <20140825202946.3d4fbaac@pomiot.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140825202946.3d4fbaac@pomiot.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 25, 2014 at 08:29:46PM +0200, Michał Górny wrote:
> I'm afraid I've hit a bug that has been introduced in 2.25 and still
> not fixed in current git.

 Yep, it's pretty ugly bug. Fixed. We need 2.25.1 really ASAP.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
