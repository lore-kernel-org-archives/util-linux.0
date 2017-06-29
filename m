Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbdF2Kzz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Jun 2017 06:55:55 -0400
Date: Thu, 29 Jun 2017 12:55:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: BUG: wipefs dry run
Message-ID: <20170629105551.ceuymhnzlcj2hetn@ws.net.home>
References: <201705101154.50099.sweet_f_a@gmx.de>
 <201705101303.10856.sweet_f_a@gmx.de>
 <20170526112120.kinsu7oi7fldx2o4@ws.net.home>
 <201706151647.06899.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706151647.06899.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 15, 2017 at 04:47:06PM +0200, Ruediger Meier wrote:
> ### the default list shows too many newlines 

libsmartcols based now (the library resolves all output issues in this
universe... problem fixed).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
