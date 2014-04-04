Return-Path: paul.betafive@gmail.com
MIME-Version: 1.0
Sender: paul.betafive@gmail.com
In-Reply-To: <20140404140949.GB22126@x2.net.home>
References: <CANyK_8d6L7vL6Mfq4VNdScjoVLb1K1+8hYsDnuQBZLOh5LC3BA@mail.gmail.com>
 <20140404140949.GB22126@x2.net.home>
From: Paul Barker <paul@paulbarker.me.uk>
Date: Fri, 4 Apr 2014 17:37:55 +0100
Message-ID: <CANyK_8fsJJPk3OS0tedOKeUPy_11r41DW3JokST77jsNNhJw-g@mail.gmail.com>
Subject: Re: Compile failure due to use of qsort_r
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 4 April 2014 15:09, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Apr 01, 2014 at 01:03:10PM +0100, Paul Barker wrote:
>> Personally I think a good solution would be to add a configure check
>> on whether qsort_r is provided and to either error out at that stage
>> or provide a workaround.
>
> Fixed.
>
> The code in libfdisk is not so important, I've made it optional by #ifdef
> HAVE_QSORT_R.
>
>     Karel
>

Many thanks!

-- 
Paul Barker

Email: paul@paulbarker.me.uk
http://www.paulbarker.me.uk
