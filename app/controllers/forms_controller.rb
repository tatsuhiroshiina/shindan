class FormsController < ApplicationController

  def create
    @form = Form.new(form_params)
    if @form.save
      redirect_to result_form_path(@form)
    else
      render :enter
    end
  end

  def destroy
  end

  def enter
    @form = Form.new
  end

  def result
    @form = Form.find_by(id: params[:id])
    if @form.product_type == "ソフトウェア"
      #省く事業
      @software = Solution.where(description: "海外イベント参加支援")
    else
      @software = nil
    end

    if @form.series != "スタートアップではない" || !@form.objective.include?("ビジネス戦略策定")
      @seed = Solution.where(title: "始動")
    else
      @seed = nil
    end

    if @form.company_type.include?("法人")
      @btob = Solution.where(description: "長期アクセラレーションプログラム").where(classification: nil).where.not(title: "内閣府アクセラレーションプログラム Enterpriseコース").where.not(title: "内閣府アクセラレーションプログラム Global Preparationコース")
    else
      @btob = nil
    end

    if @form.industry.include?("環境")
      @cleantech = Solution.where(description: "長期アクセラレーションプログラム").where(classification: nil).where.not(title: "内閣府アクセラレーションプログラム CleanTechコース").where.not(title: "内閣府アクセラレーションプログラム Global Preparationコース")
    else
      @cleantech = nil
    end

    if @form.industry.include?("バイオ")
      @bio = Solution.where(description: "長期アクセラレーションプログラム").where(classification: nil).where.not(title: "内閣府アクセラレーションプログラム Bio/Healthcareコース").where.not(title: "内閣府アクセラレーションプログラム Global Preparationコース")
    else
      @bio = nil
    end

    if @form.industry.include?("大学発")
      @university = Solution.where(description: "長期アクセラレーションプログラム").where(classification: nil).where.not(title: "内閣府アクセラレーションプログラム Universityコース").where.not(title: "内閣府アクセラレーションプログラム Global Preparationコース")
    else
      @university = nil
    end

    if @form.industry == "その他"
      @other = Solution.where(title: "内閣府アクセラレーションプログラム Universityコース").or(Solution.where(title: "内閣府アクセラレーションプログラム Bio/Healthcareコース")).or(Solution.where(title: "内閣府アクセラレーションプログラム CleanTechコース"))
    else
      @other = nil
    end

    if @form.series == "シリーズB" || "シリーズC〜"
      @seriesbc = Solution.where.not(classification: "X-Hub").where(description: "長期アクセラレーションプログラム")
    else
      @seriesbc = nil
    end

    if @form.region.include?("アジア")
      @asia = nil
    else
      @asia = Solution.where(title: "Ignite").or(Solution.where(title: "X-Hub 深センコース")).or(Solution.where(title: "X-Hub 深センコース")).or(Solution.where(title: "X-Hub シンガポールコース"))

    end

    if @form.region.include?("北米")
      @usa = nil
    else
      @usa = Solution.where(title: "CES").or(Solution.where(title: "Disrupt")).or(Solution.where(title: "Collision")).
      or(Solution.where(title: "X-Hub ニューヨークコース")).or(Solution.where(title: "X-Hub シリコンバレーコース"))
    end


    if @form.region.include?("アフリカ")
      @africa = nil
    else
      @africa = Solution.where(title: "Gitex Future Stars")
    end

    if @form.region.include?("欧州")
      @europe = nil
    else
      #欧州が入っていなければ表示しない
      @europe = Solution.where(title: "X-Hub ドイツコース").or(Solution.where(title: "VIVA Tech")).or(Solution.where(title: "X-Hub 欧州コース")).or(Solution.where(title: "4 Years From Now"))
    end

    if @form.objective.include?("人材獲得")
      @recruitment = nil
    else
      @recruitment = Solution.where(title: "Japan Day")
    end

    if @form.objective.include?("貿易実務")
      @trade = nil
    else
      @trade = Solution.where(title: "貿易投資相談")
    end

    if @form.objective.include?("ビジネス戦略策定") || @form.objective.include?("人材獲得") || @form.objective.include?("販路開拓")|| @form.objective.include?("拠点設立")|| @form.objective.include?("協業連携")|| @form.objective.include?("市場調査")|| @form.objective.include?("資金調達")
      @gah = nil
    else
      @gah = Solution.where(title: "グローバル・アクセラレーション・ハブ")
    end

    if @form.objective.include?("ビジネス戦略策定")|| @form.objective.include?("資金調達")|| @form.objective.include?("市場調査")
      @acceleration = nil
    else
      @acceleration = Solution.where(description: "長期アクセラレーションプログラム")
    end


    @solutions = Solution.where.not(id: @software).where.not(id: @seriesc).where.not(id: @cleantech).where.not(id: @bio).where.not(id: @other).where.not(id: @university).where.not(id: @asia).where.not(id: @usa).where.not(id: @africa).where.not(id: @europe).where.not(id: @selling).where.not(id: @acceleration).where.not(id: @seed).where.not(title: "貿易投資相談").where.not(id: @recruitment).where.not(id: @seriesab).where.not(id: @btob).where.not(id: @acceleration).where.not(id: @gah).where.not(id: @recruitment).where.not(id: @seriesbc).where.not(id: @trade).order('description ASC')

    if @form.series == "スタートアップではない"
      @solutions = Solution.where(title: "始動").or(Solution.where(title: "貿易投資相談")).or(Solution.where(title: "Japan Day"))
    end
  end

  private
    def form_params #ストロングパラメータ
      params.require(:form).permit(:industry, :series, :product_type, :company_type, {:region => []},{:objective => []}, :field, :objective) #パラメーターのキー
    end

end
