Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751693AbeA3LCs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 06:02:48 -0500
Date: Tue, 30 Jan 2018 12:02:44 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [v2 PATCH 4/4] cal: new option toggles the calendar system header
Message-ID: <20180130110244.luzqd5wgfmiucq2m@ws.net.home>
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
 <875bde54-8488-1a3d-5edc-f64f553ce228@gmx.com>
 <a846dfd3-950c-1616-7cdf-03395aef5c0d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a846dfd3-950c-1616-7cdf-03395aef5c0d@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 26, 2018 at 07:26:40PM -0500, J William Piggott wrote:
> +.BR \-\-top-header\ on | off
> +Toggle displaying of the calendar system header (default on).

I don't like the name of the option, what about

    --calendar-type-header=on|off

and default OFF.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
