Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33817 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdEDUxX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 4 May 2017 16:53:23 -0400
Received: by mail-qk0-f170.google.com with SMTP id k74so21483252qke.1
        for <util-linux@vger.kernel.org>; Thu, 04 May 2017 13:53:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 4 May 2017 21:53:21 +0100
Message-ID: <CAG27Bk1XLAD3yK7EcuzrsCF5zj4wT0sAMjk4X=a3SB9+RQ1JWA@mail.gmail.com>
Subject: column tree id-parent loop crash
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

$ printf "%s\n%s\n" "a 1 0" "b 0 1" | column
--table-columns=NAME,ID,PARENT --tree NAME --tree-id ID --tree-parent
PARENT
Segmentation fault (core dumped)

I'm not sure what the command should do in this case. Maybe print some
sort of symbol of circle, such as below??

NAME  ID  PARENT
 a    1   0
( )
 b    0   1

The easiest option is to print complaint about circular input. IMHO
such complaint should inform ID & PARENT fields are in question to
make users life a little easier.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
