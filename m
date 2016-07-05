Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:55403 "EHLO
	resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751986AbcGESkg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Jul 2016 14:40:36 -0400
From: worley@alum.mit.edu (Dale R. Worley)
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: question about raw(1)
In-Reply-To: <201607041539.37149.sweet_f_a@gmx.de>
Date: Tue, 05 Jul 2016 14:32:24 -0400
Message-ID: <871t38djgn.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meier <sweet_f_a@gmx.de> writes:
> I'm just curious, would this always work?: 
>
>   modprobe raw
>   raw /dev/raw/raw1 /dev/xyz
>
> or should you wait for /dev/raw/rawctl after modprobe (udevadm settle or 
> sleep)?

Interesting -- the modprobe manual page doesn't state explicitly whether
or not the module initialization actions will be completed before
modprobe returns.

Dale
