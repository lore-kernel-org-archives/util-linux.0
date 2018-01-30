Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeA3LIH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 06:08:07 -0500
Date: Tue, 30 Jan 2018 12:08:04 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] cal: remove year top header
Message-ID: <20180130110804.dxg3lk2qdqetpink@ws.net.home>
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
 <425f0c7b-5f76-675a-95b4-f4aeee1b25a9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <425f0c7b-5f76-675a-95b4-f4aeee1b25a9@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 24, 2018 at 07:53:11PM -0500, J William Piggott wrote:
>  misc-utils/cal.c | 32 +++-----------------------------
>  1 file changed, 3 insertions(+), 29 deletions(-)

Do I understand correctly that "cal -y" will not display year on the 
top and year will be always behind all month names?

If yes, I'm not sure if I like it. I understand that "Month Year" is a
good thing for complicated outputs (especially cross year borders), 
but if I ask for all year (by -y)?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
