Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbdBAPWC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Feb 2017 10:22:02 -0500
Date: Wed, 1 Feb 2017 16:21:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Michal Soltys <soltys@ziu.info>
Cc: util-linux@vger.kernel.org
Subject: Re: findmnt under container
Message-ID: <20170201152157.fpr47leymkltmupe@ws.net.home>
References: <008ff846-8010-44ef-2056-5e0ecdc355c1@ziu.info>
 <20170201114246.tpjirhsk52qaijuo@ws.net.home>
 <3716efe8-d5bd-c4af-4180-975fa3a112cb@ziu.info>
 <20170201144623.5pvxhdfeyfwmhnrb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201144623.5pvxhdfeyfwmhnrb@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 01, 2017 at 03:46:23PM +0100, Karel Zak wrote:
> The findmnt uses these columns to compose the output tree. Unfortunately it
> assumes that root FS has the smallest ID. That's not true in your container.
> I'll try to fix it.

Fixed, commit:
https://github.com/karelzak/util-linux/commit/1a3397906dc35bf017f5382001eaf60e717d0a8f

will be in v2.29.2. Thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
