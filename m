Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbcJTGDP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 02:03:15 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Date: Thu, 20 Oct 2016 08:03:03 +0200
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
In-Reply-To: <20161019132505.cumn37cmgazlumcu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610200803.04150.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 19 October 2016, Karel Zak wrote:
> The util-linux release v2.29-rc1 is available at
>
>   http://ftp.kernel.org/pub/linux/utils/util-linux/v2.29/
>
> Feedback and bug reports, as always, are welcomed.
>
>     Karel

Looks like ncurses(w) detection does not work anymore without pkgconfig 
files, for example on openSUSE <=13.1, SLE 12 and openSUSE Leap.

cu,
Rudi 


