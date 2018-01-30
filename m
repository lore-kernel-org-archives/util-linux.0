Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751745AbeA3MVo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 07:21:44 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/4] cal: remove year top header
Date: Tue, 30 Jan 2018 13:21:36 +0100
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com> <425f0c7b-5f76-675a-95b4-f4aeee1b25a9@gmx.com> <20180130110804.dxg3lk2qdqetpink@ws.net.home>
In-Reply-To: <20180130110804.dxg3lk2qdqetpink@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201801301321.36966.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 30 January 2018, Karel Zak wrote:
> On Wed, Jan 24, 2018 at 07:53:11PM -0500, J William Piggott wrote:
> >  misc-utils/cal.c | 32 +++-----------------------------
> >  1 file changed, 3 insertions(+), 29 deletions(-)
>
> Do I understand correctly that "cal -y" will not display year on the
> top and year will be always behind all month names?
>
> If yes, I'm not sure if I like it. I understand that "Month Year" is
> a good thing for complicated outputs (especially cross year borders),
> but if I ask for all year (by -y)?


I'd also like to see the year only once per year. FreeBSD's cal does it 
very nice IMO.

Unfortunately we have this bloated output already now in 

$ cal -n 36
