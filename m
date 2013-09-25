Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab3IYJ0W (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Sep 2013 05:26:22 -0400
Date: Wed, 25 Sep 2013 11:26:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <davidlohr@hp.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] libfdisk: gpt: do not assume first pt record is
 always pmbr
Message-ID: <20130925092619.GA30581@x2.net.home>
References: <1379821516-2540-1-git-send-email-davidlohr@hp.com>
 <1379821516-2540-2-git-send-email-davidlohr@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379821516-2540-2-git-send-email-davidlohr@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 21, 2013 at 08:45:15PM -0700, Davidlohr Bueso wrote:
> The 0xEE (GPT protective) partition does not always have to be
> the first element in the array of MBR partition records.

 Already fixed.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
