Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:37297 "EHLO
	resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864AbaKYPUm (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 25 Nov 2014 10:20:42 -0500
Date: Tue, 25 Nov 2014 10:20:40 -0500
Message-Id: <201411251520.sAPFKeID013159@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Karel Zak <kzak@redhat.com>
CC: psusi@ubuntu.com, drake@dasyatidae.net, util-linux@vger.kernel.org,
        770211@bugs.debian.org
In-reply-to: <20141124154604.GA2610@x2.net.home> (kzak@redhat.com)
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net>
 <20141124113733.GC926@x2.net.home>
 <547343EA.6090606@ubuntu.com> <20141124154604.GA2610@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Karel Zak <kzak@redhat.com>

>  well, it's designed for auto-generated fstab-less systems like
>  containers/virt images, etc. I'm not big fan of this feature, but for
>  some use cases it makes sense.

I thought that's what filesystem "label" values were for.

>  (And it's systemd upstream decision.)

I've never run into something from systemd that I didn't consider
bizarre and horrible, designed to solve problems I don't have at the
cost of making my life worse.

Dale
