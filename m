Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeAVN2p (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jan 2018 08:28:45 -0500
Date: Mon, 22 Jan 2018 14:28:41 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] cal: fix week calculations for 1752
Message-ID: <20180122132841.6axu2ji3uzi2q523@ws.net.home>
References: <a6d50a7c-6938-6f29-a983-039c5a422a7f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a6d50a7c-6938-6f29-a983-039c5a422a7f@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 22, 2018 at 07:01:23AM -0500, J William Piggott wrote:
>  misc-utils/cal.c | 3 +++
>  1 file changed, 3 insertions(+)

The both patches applied, and "--week=40 1752" added to tests.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
