Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913Ab2EOJft (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 05:35:49 -0400
Date: Tue, 15 May 2012 11:35:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] lib,include: move get_terminal_width() to ttyutils.h
Message-ID: <20120515093525.GK8268@x2.net.home>
References: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
 <1337071744-7056-3-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337071744-7056-3-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 15, 2012 at 10:49:03AM +0200, Petr Uzel wrote:
>  include/ttyutils.h |   29 +++++++++++++++++++++++++++++
>  lib/tt.c           |   28 +---------------------------
>  2 files changed, 30 insertions(+), 27 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
