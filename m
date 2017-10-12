Return-Path: linux-kernel-owner@vger.kernel.org
Date: Thu, 12 Oct 2017 12:13:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20171012101311.zfvg6edfvszlujom@ws.net.home>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali>
 <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
 <20171012092113.2bsb3pzv6un4xahr@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171012092113.2bsb3pzv6un4xahr@pali>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 12, 2017 at 11:21:13AM +0200, Pali Rohár wrote:
> > The best for me is to keep blkid output backwardly compatible as much
> > as possible :-)
> 
> Backward compatibility is a good reason. But what with situation when
> interoperability with other systems (e.g. Windows) does not work as
> expected?

Then... I'm ready to do the changes to keep interoperability with the
rest of the universe. It's the same situation as with UDF, you know...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
