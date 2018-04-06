Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751570AbeDFLM5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 6 Apr 2018 07:12:57 -0400
Date: Fri, 6 Apr 2018 13:12:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] misc-utils/getopt.1: minor corrections to the manual
Message-ID: <20180406111250.6lzp3btqz2pyb4kl@ws.net.home>
References: <n>
 <1522358106-21037-1-git-send-email-bjarniig@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522358106-21037-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 29, 2018 at 09:15:06PM +0000, Bjarni Ingi Gislason wrote:
> Input file is getopt.1

Applied (both patches), thanks.

> Test nr. 20:
> 
> Use a macro to change to the italic font, instead of \fI [1], if
> possible.

Not sure if I like it. The \f makes man pages code more readable and
compact from my point of view.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
