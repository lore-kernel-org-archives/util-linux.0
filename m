Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbeA3K6j (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 05:58:39 -0500
Date: Tue, 30 Jan 2018 11:58:35 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] cal: new top header to display the calendar system
Message-ID: <20180130105835.hq6rl6mdoaqxmfua@ws.net.home>
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
 <6022019c-48a2-770c-c025-683025067976@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6022019c-48a2-770c-c025-683025067976@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 24, 2018 at 08:02:10PM -0500, J William Piggott wrote:
> 
> Output a top header showing what calendar system is being
> displayed: Julian, Gregorian, or Mixed.

This is overkill and strange thing, at least by default. I have no 
problem to add a command line option for this feature, but don't
enable it by default. Please.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
