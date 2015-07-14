Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34777 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbGNUQ6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2015 16:16:58 -0400
Received: by iebmu5 with SMTP id mu5so19357988ieb.1
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2015 13:16:58 -0700 (PDT)
Received: from brickies-eth0.mosers.us (d149-67-16-30.nap.wideopenwest.com. [67.149.30.16])
        by smtp.gmail.com with ESMTPSA id g81sm1260969ioi.20.2015.07.14.13.16.57
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 13:16:57 -0700 (PDT)
Date: Tue, 14 Jul 2015 16:16:56 -0400 (EDT)
From: Scott Moser <smoser@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: GPT writing of unknown partition uuids
Message-ID: <alpine.DEB.2.02.1507141610310.21273@brickies>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I came to send the previous patch after realizing that the following is a
lossy operation if the GUID type for the partition is not known to sfdisk.

$ img="/tmp/my.img"
$ size="100M"

$ rm -f "$img"
$ truncate --size "$size" "$img"
$ GPT_PREP="9E1A2D38-C612-4316-AA26-8B49521E5A8B"
$ PT1_UUID="7EB5EBCA-1611-431B-9C80-D87300B41B3B"
$ LABEL_UUID="3C5AD185-CFBF-480D-B80C-AD089E073AC9"

$ sfdisk "$img" <<EOF
label: gpt
label-id: $LABEL_UUID
unit: sectors
1 : start=2048, size=16384, type=$GPT_PREP, uuid=$PT1_UUID
EOF

If sfdisk does not know the uuid provided, it silently falls back to
0FC63DAF-8483-4772-8E79-3D69D8477DE4 (Linux filesystem).

It seems like if the user provided you with a GUID, sfdisk should trust
them, or at very least exit failure if it refuses to use the provided
GUID.

Thoughts?
Scott
