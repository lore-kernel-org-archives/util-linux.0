Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.74]:62924 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdFHF0y (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 01:26:54 -0400
Subject: Re: [PATCH 6/6] misc: fix some warnings
To: Bruce Dubbs <bruce.dubbs@gmail.com>, kerolasa@gmail.com,
        J William Piggott <elseifthen@gmx.com>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
 <1496279320-14541-7-git-send-email-sweet_f_a@gmx.de>
 <0035d164-75ac-f892-2cbe-0fb8184116cb@gmx.com>
 <201706061010.07911.sweet_f_a@gmx.de>
 <de2ea265-ed30-8493-7267-a113b9140a5d@gmx.com>
 <42e92093-bed4-daa0-e2cd-f90205e17f8b@gmx.com>
 <CAG27Bk1W2wbSFoAV70EpWT-2USvmuHV_muC2DODr8ALODTS_ww@mail.gmail.com>
 <5938335F.9090108@gmail.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <7da22ebc-dcbb-0533-c19a-c48d53d8b2be@bernhard-voelker.de>
Date: Thu, 8 Jun 2017 07:26:50 +0200
MIME-Version: 1.0
In-Reply-To: <5938335F.9090108@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/07/2017 07:09 PM, Bruce Dubbs wrote:
> IMO, embedded tabs in source code add nothing but problems.

+1 for my personal taste as well.

IMO each project should just define its own indent(1) settings
and document them e.g. in README or README-HACKING, and then
nobody would have to think about it.

Have a nice day,
Berny
