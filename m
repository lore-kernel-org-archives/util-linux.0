Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751151AbeCGKv4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Mar 2018 05:51:56 -0500
Date: Wed, 7 Mar 2018 11:51:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidd: don't truncate long socket paths
Message-ID: <20180307105151.ouq2poo2dc7irud2@ws.net.home>
References: <a1b8906b-0077-79c9-db5a-2d91756c2ebb@gentoo.org>
 <20180307094023.21198-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180307094023.21198-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:40:23AM +0100, Ruediger Meier wrote:
>  misc-utils/uuidd.c  | 12 ++++++++----
>  tests/ts/uuid/uuidd |  3 ++-
>  2 files changed, 10 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
