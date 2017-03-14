Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbdCNNRI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Mar 2017 09:17:08 -0400
Date: Tue, 14 Mar 2017 14:17:05 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [V3 PULL] hwclock: remove date(1)
Message-ID: <20170314131705.vag4vmrlemrcfsj4@ws.net.home>
References: <a1415b5d-4046-3b34-5836-40ce1a835a41@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a1415b5d-4046-3b34-5836-40ce1a835a41@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 04, 2017 at 04:56:12PM -0500, J William Piggott wrote:
>  Here's the latest branch for adding parse-date.

Reviewed, it seems ready do merge from my point of view. Objections?

TODO (after merge):
  - add lib/test_parse_date.c
  - add tests/ts/misc/parse_date regression test
  - replace parse_timestamp() with new parse_date() 


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
